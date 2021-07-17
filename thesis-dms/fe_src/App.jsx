import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import { checkLoginStatus, userLoginStatus, LOGIN_STATUS } from './store/usersSlice';
import Header from './components/header/Header';
import LoginForm from './components/authenticate/LoginForm';
import setupCsrfToken from './services/csrfService';

const App = () => {
  const dispatch = useDispatch();
  const loggedin = useSelector(userLoginStatus);
  const [loggedinState, setLoggedinState] = useState(loggedin);

  useEffect(() => {
    setupCsrfToken();
    dispatch(checkLoginStatus());
  }, [dispatch]);

  useEffect(() => {
    setLoggedinState(loggedinState);
  }, [loggedinState]);

  let rootComponent;
  if (loggedin === null) {
    rootComponent = null;
  } else if (loggedin === LOGIN_STATUS.NOT_LOGGED_IN) {
    rootComponent = LoginForm;
  } else {
    rootComponent = null; // TODO: default root component
  }

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
