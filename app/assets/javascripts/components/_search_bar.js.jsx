var SearchBar = React.createClass({
  handleClick(key, value, selected) {
    console.log(selected);
    if(selected == true) {
      return this.props.handleFacetUnCheck(key, value);
    }
    return this.props.handleFacetCheck(key, value);
  },

  facetList(key, list) {
    return list.map(function(item){
      return (
        <label key={item.value} className="checkbox-inline">
          <input type="checkbox" value={item.value} checked={item.selected}
            onChange={this.handleClick.bind(this, key, item.value, item.selected)}/>
          {item.entity} ({item.count})
        </label>
      )
    }, this);
  },

  facetBar(){
    let facet = this.props.facet;
    return Object.keys(facet).map(function(key) {
      return (
        <div key={key} className="col-sm-3 col-md-4">
          <div className="panel-group">
            <div className="panel panel-default">
              <div className="panel-heading">
                <h4 className="panel-title">
                  <span className="glyphicon glyphicon-tag"></span> {key}
                </h4>
              </div>
              <form>
                {this.facetList(key, facet[key])}
              </form>
            </div>
          </div>
        </div>
      )
    }, this);
  },

  handleTextSearch(e) {
    e.preventDefault();
    this.props.handleTextSearch(e.target.search.value);
  },

  textSearchBox() {
    return(
      <div className="col-sm-3 col-md-4">
        <div className="search-container">
          <form onSubmit={this.handleTextSearch}>
            <input type="text" placeholder={this.props.search.name} name="search" />
            <button type="submit"><i className="fa fa-search"></i></button>
          </form>
        </div>
      </div>
    )
  },

  render() {
    return (
    <div className="row">
      {this.facetBar()}
      {this.textSearchBox()}
    </div>
    )
  }
});
