var MovieBox = React.createClass({
  getInitialState() {
    return { movies: [], page: 1, total_pages: 1 }
  },

  componentDidMount(){
    $.getJSON('/movies.json', (response) => {
      console.log(response);
      this.setState({movies: response.movies, page: response.page, total_pages: response.total_pages})
    });
  },

  handlePageChange(page) {
    $.getJSON('/movies.json', {page: page}, (response) => {
      this.setState({movies: response.movies, page: response.page, total_pages: response.total_pages})
    });
  },

  render() {
    return (
      <div>
        <AllMovies movies={this.state.movies}/>
        <Pagination page={this.state.page} total_pages={this.state.total_pages} handlePageChange={this.handlePageChange}/>
      </div>
    )
  }
});
