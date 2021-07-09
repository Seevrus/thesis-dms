import React, { useEffect } from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import LoginPage from './pages/LoginPage';
import setupCsrfToken from './services/csrfService';

const App = () => {
  useEffect(() => {
    setupCsrfToken();
  }, []);

  return (
    <Router>
      <Switch>
        <Route path="/" component={LoginPage} />
      </Switch>
    </Router>
  );
};

export default App;
