var Ratings = React.createClass({
  getInitialState() {
    return { index: 0, defaultValue: 0 }
  },

  handleHover(index) {
    this.setState({index: index, defaultValue: this.state.defaultValue});
  },

  handleClick(value) {
    this.setState({index: value, defaultValue: value});
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
