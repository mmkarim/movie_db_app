var Main = React.createClass({
  getInitialState() {
    let searchParams = {categories: [], average_rating:[], name: ""};
    let facet = {categories: [], average_rating:[]};
    return { movies: [], page: 1, total_pages: 1, search: searchParams, facet: facet }
  },

  handleDelete(movieId) {
    $.ajax({
        url: `/movies/${movieId}`,
        type: 'DELETE',
        data: {jwt: this.props.jwt},
        dataType: "json",
        success:(response) => {
          this.handlePageChange(this.state.page);
        },
        error:(response) => {
          alert("Authorization Failed!");
        }
    });
  },

  componentDidMount(){
    this.handlePageChange();
  },

  handlePageChange(page=this.state.page, search=this.state.search) {
    $.getJSON('/movies.json', {page: page, search: search}, (response) => {
      this.setState({
        movies: response.movies,
        page: response.page,
        total_pages: response.total_pages,
        search: response.search,
        facet: response.facet
      })
    });
  },

  handleFacetUnCheck(key, value) {
    let index = this.state.search[key].indexOf(value);
    this.state.search[key].splice(index, 1);
    this.handlePageChange(1, this.state.search);
  },

  handleFacetCheck(key, value) {
    this.state.search[key].push(value);
    this.handlePageChange(1, this.state.search);
  },

  handleTextSearch(text) {
    this.state.search.name = text;
    this.handlePageChange(1, this.state.search);
  },

  render() {
    return (
      <div>
        <SearchBar
          facet={this.state.facet}
          search={this.state.search}
          handleFacetUnCheck={this.handleFacetUnCheck}
          handleFacetCheck={this.handleFacetCheck}
          handleTextSearch={this.handleTextSearch}
        />
        <AllMovies
          movies={this.state.movies}
          handleDelete={this.handleDelete}
          jwt={this.props.jwt}
          userId={this.props.user_id}
        />
        <Pagination
          page={this.state.page}
          total_pages={this.state.total_pages}
          handlePageChange={this.handlePageChange}
        />
      </div>
    )
  }
});
