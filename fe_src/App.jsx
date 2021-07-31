import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import { checkLoginStatus, LOGIN_STATUS, userLoginStatus } from './store/usersSlice';
import Documents from './components/Documents';
import EmailValidationForm from './components/authenticate/EmailValidationForm';
import Header from './components/header/Header';
import LoginForm from './components/authenticate/LoginForm';
import Logout from './components/authenticate/Logout';
import Profile from './components/Profile';
import RegistrationCompletitionForm from './components/authenticate/RegistrationCompletitionForm';
import setupCsrfToken from './services/csrfService';
import UserActivity from './components/UserActivity';
import UserHandling from './components/UserHandling';

const App = () => {
  const dispatch = useDispatch();
  const loginStatus = useSelector(userLoginStatus);
  const [loggedinState, setLoggedinState] = useState(loginStatus);

  useEffect(() => {
    setupCsrfToken();
    dispatch(checkLoginStatus());
  }, [dispatch]);

  useEffect(() => {
    setLoggedinState(loggedinState);
  }, [loggedinState]);

  let rootComponent;
  if (loginStatus === null) {
    rootComponent = null;
  } else if (loginStatus === LOGIN_STATUS.NOT_LOGGED_IN) {
    rootComponent = LoginForm;
  } else {
    rootComponent = Documents;
  }

  return (
    <>
      <Router>
        <Header />
        <Switch>
          <Route exact path="/" component={rootComponent} />
          <Route exact path="/complete-registration" component={RegistrationCompletitionForm} />
          <Route exact path="/documents" component={Documents} />
          <Route exact path="/login" component={LoginForm} />
          <Route exact path="/logout" component={Logout} />
          <Route exact path="/profile" component={Profile} />
          <Route exact path="/user-activity" component={UserActivity} />
          <Route exact path="/user-handling" component={UserHandling} />
          <Route exact path="/validate-email" component={EmailValidationForm} />
        </Switch>
      </Router>
    </>
  );
};

export default App;
