var AllMovies = React.createClass({
  handleDelete(movieId) {
    this.props.handleDelete(movieId)
  },

  crudButtons(movie) {
    if(!!this.props.jwt && movie.user_id == this.props.userId) {
      return (
        <div>
          <a href={"/movies/"+movie.id+"/edit"} className="btn btn-info btn-xs" role="button">
            Edit
          </a>
          <button
            onClick={this.handleDelete.bind(this, movie.id)}
            className="btn btn-danger btn-xs">
              Delete
          </button>
        </div>
      )
    } else {
      return null;
    }
  },

  userRatingBar(movie) {
    if(!!this.props.jwt) {
      return (
        <div>
          <small>Submit Your Rating: </small><Ratings movie={movie} jwt={this.props.jwt}/>
        </div>
      )
    } else {
      return null;
    }
  },

  showCategories(categories) {
    return categories.map(function(item){
      return (
        <span key={item.id} className="label label-success">
          {item.name}
        </span>
      )
    });
  },

  averageRatingBar(value) {
    let result = [];
    for (var i = 1; i <= 5; i++) {
      result.push(
        <span key={i} className={i <= value ? "fa fa-star checked" : "fa fa-star"}>
        </span>
      );
    }
    return result;
  },

  showMovie(movie) {
    return (
      <div className="media">
        <div className="media-left">
        <a href={"/movies/"+movie.id}>
          <img className="media-object" src="https://www.directv.com/img/movies.jpg" alt="">
          </img>
        </a>
        </div>
        <div className="media-body">
          <div>
            <a href={"/movies/"+movie.id}>
              <h4 className="media-heading">{movie.name}</h4>
            </a>
          </div>
          <div><small>{this.showCategories(movie.categories)}</small></div>
          <small>Avg. Rating: </small>
          {this.averageRatingBar(movie.average_rating)}({movie.average_rating})
          {this.userRatingBar(movie)}
          <div><small>{movie.text}</small></div>
        </div>
      </div>
    )
  },

  render() {
    var movies = this.props.movies.map((movie) => {
      return(
        <div key= {movie.id}>
          <div className="row" >
            <div className="col-md-6">
              {this.showMovie(movie)}
            </div>

            <div className="col-md-4">
              <div className="media">
                <div className="media-left">
                  {this.crudButtons(movie)}
                </div>
              </div>
            </div>

            <div className="col-md-2">
              <div className="media">
                <div className="media-left">
                </div>
              </div>
            </div>
          </div>
          <hr></hr>
        </div>
      )
    });

    return (
      <div className="jumbotron moviebox">
        {movies}
      </div>
    )
  }
});
