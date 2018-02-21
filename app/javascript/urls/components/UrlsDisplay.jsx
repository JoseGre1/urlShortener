import React from 'react';
import { Link } from 'react-router-dom';
import queryString from 'query-string';
import axios from 'axios';
import {CopyToClipboard} from 'react-copy-to-clipboard';
import Notifications, {notify} from 'react-notify-toast';

class UrlsDisplay extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      url: {},
      clipboard: {
        visible: false,
        copied: false,
        value: '',
      },
      submit: {
        disabled: false
      }
    };

    this.postUrl = this.postUrl.bind(this);
    this.originalUrlChange = this.originalUrlChange.bind(this);
    this.onCopy = this.onCopy.bind(this);
  }

  postUrl = (event) => {
    axios.post( `/api/v1/urls`, {
        url: { original: this.state.url.original}
      })
      .then(response => {
        this.setState({ url: {shortened_url: response.data.shortened_url} });
        this.setState({ clipboard:{visible: true} });
        notify.show("Shortened!", "success");
        this.setState({ submit: { disabled: true }});
      })
      .catch(error => {
        notify.show("Ooops! Something has occured", "error");
      });
      event.preventDefault();
  }

  originalUrlChange = (event) => {
    this.setState({ clipboard: {visible: false} });
    this.setState({ url: { original: event.target.value }});
    this.setState({ submit: { disabled: false }});
  }

  onCopy = () => {
    this.setState({ clipboard: {copied: true, visible: true} });
    notify.show("Copied!", "success");
  }

  render () {
    const nextUrlId = Number(this.state.url.id) + 1;

    return (
      <div>
        <form onSubmit={this.postUrl}>
          <div className="form-row">
            <div className="col-12 col-md-9 mb-2 mb-md-0">
              <input type="url" className="form-control form-control-lg bg-blur" onChange={this.originalUrlChange} placeholder="Enter an URL..." />
            </div>
            <div className="col-12 col-md-3">
              <button type="submit" className="btn btn-block btn-lg btn-primary" disabled={this.state.submit.disabled}>Shorten</button>
            </div>
          </div>
        </form>
        <div className="mt-3"></div>
        <div className="row">
            <div className="col-12 col-md-9 mb-2 mb-md-0">
              <a className="text-shadow" href={this.state.url.shortened_url}><h6>{this.state.url.shortened_url}</h6></a>
            </div>
            <div className="col-12 col-md-3">
              <CopyToClipboard onCopy={this.onCopy} text={this.state.url.shortened_url}>
                <button
                  type="button"
                  className="btn btn-block btn-lg btn-success"
                  style={{ visibility: this.state.clipboard.visible ? 'visible' : 'hidden' }}>Copy</button>
              </CopyToClipboard>
            </div>
          </div>
      </div>
    );
  }
}

export default UrlsDisplay;
