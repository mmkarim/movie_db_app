var MovieBox = React.createClass({
  getInitialState() {
    return { movies: [], page: 1, total_pages: 1 }
  },

  handleDelete(movieId) {
    $.ajax({
        url: `/movies/${movieId}`,
        type: 'DELETE',
        data: {jwt: this.props.jwt},
        dataType: "json",
        success:(response) => {
          this.componentDidMount(this.state.page);
        },
        error:(response) => {
          alert("Authorization Failed!");
        }
    });
  },

  componentDidMount(page=this.state.page){
    $.getJSON('/movies.json', {page: page}, (response) => {
      console.log(response);
      this.setState({movies: response.movies, page: response.page, total_pages: response.total_pages})
    });
  },

  handlePageChange(page) {
    this.componentDidMount(page);
  },

  render() {
    return (
      <div>
        <AllMovies movies={this.state.movies} handleDelete={this.handleDelete} jwt={this.props.jwt} userId={this.props.user_id}/>
        <Pagination page={this.state.page} total_pages={this.state.total_pages} handlePageChange={this.handlePageChange}/>
      </div>
    )
  }
});
