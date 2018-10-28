var Ratings = React.createClass({
  getInitialState() {
    let userRating = this.props.movie.user_rating;
    return { index: userRating, defaultValue: userRating }
  },

  handleHover(index) {
    this.setState({index: index, defaultValue: this.state.defaultValue});
  },

  handleClick(value) {
    $.ajax({
      url: `/ratings/`,
      type: 'POST',
      data: {jwt: this.props.jwt, movie_id: this.props.movie.id, value: value},
      dataType: "json",
      success:(response) => {
        this.setState({index: value, defaultValue: value});
      },
      error:(response) => {
        alert("Authorization Failed!");
      }
    });
  },

  render() {
    let result = [];
    let index = this.state.index;

    for (var i = 1; i <= 5; i++) {
      result.push(
        <span key={i} onMouseEnter={this.handleHover.bind(this, i)}
        onMouseLeave={this.handleHover.bind(this, this.state.defaultValue)}
        onClick={this.handleClick.bind(this, i)}
        className={i <= index ? "fa fa-star checked" : "fa fa-star"}></span>
      );
    }

    return (
      <div>
        {result}
      </div>
    )
  }
});
