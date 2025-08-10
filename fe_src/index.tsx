import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { Provider } from 'react-redux';

import 'bootstrap/dist/css/bootstrap.min.css';
import './assets/css/animate.min.css';
import './assets/scss/light-bootstrap-dashboard-react.scss';
import '@fortawesome/fontawesome-free/css/all.min.css';

import App from './App';
import store from './store/store';

const rootElement = document.getElementById('root');

ReactDOM.render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>,
  rootElement,
);
