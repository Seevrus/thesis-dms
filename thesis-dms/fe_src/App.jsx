import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import { checkLoginStatus, isUserLoggedin } from './store/usersSlice';
import Header from './components/header/Header';
import LoginForm from './components/authenticate/login/LoginForm';
import setupCsrfToken from './services/csrfService';

const App = () => {
  const dispatch = useDispatch();
  const loggedin = useSelector(isUserLoggedin);
  const [loggedinState, setLoggedinState] = useState(loggedin);

  useEffect(() => {
    setupCsrfToken();
    dispatch(checkLoginStatus());
  }, [dispatch]);

  useEffect(() => {
    setLoggedinState(loggedinState);
  }, [loggedinState]);

  let rootComponent;
  if (loggedin === null) rootComponent = null;
  else if (loggedin === 0) rootComponent = LoginForm;
  else rootComponent = null; // TODO: default root component

  return (
    <>
      <Header />
      <Router>
        <Switch>
          <Route path="/" component={rootComponent} />
        </Switch>
      </Router>
    </>
  );
};

export default App;
