import React from 'react'
import ReactDOM from 'react-dom'
import App from './components/App'
import Notifications, {notify} from 'react-notify-toast';

const urls = document.querySelector('#urls')
ReactDOM.render(
  <div>
    <Notifications />
    <App />
  </div>
, urls)
