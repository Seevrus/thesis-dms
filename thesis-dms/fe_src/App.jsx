import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import LoginPage from './pages/LoginPage';

const App = () => (
  <Router>
    <Switch>
      <Route path="/" component={LoginPage} />
    </Switch>
  </Router>
);

export default App;
