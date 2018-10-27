var Pagination = React.createClass({
  handlePageChange(page) {
    this.props.handlePageChange(page)
  },

  render() {
    let result = [];
    let page = Number(this.props.page);
    let total_pages = Number(this.props.total_pages);
    let next = total_pages > page;
    let prev = page > 1;

    for (var i = 1; i <= this.props.total_pages; i++) {
      result.push(
        <li key={i} className="page-item">
          <a className="page-link" onClick={this.handlePageChange.bind(this, i)} href="javascript:;">{i}</a>
        </li>
      );
    }

    return (
      <nav aria-label="Page navigation example">
        <ul className="pagination justify-content-center">
          <li className={prev ? "page-item" : "page-item disabled"}>
            <a className="page-link" onClick={prev ? this.handlePageChange.bind(this, page - 1) : null} href="javascript:;">Previous</a>
          </li>
            {result}
          <li className={next ? "page-item" : "page-item disabled"}>
            <a className="page-link" onClick={next ? this.handlePageChange.bind(this, page + 1) : null} href="javascript:">Next</a>
          </li>
        </ul>
      </nav>
    )
  }
});
