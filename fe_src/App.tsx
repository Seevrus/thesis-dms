import * as React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import { useAppDispatch, useAppSelector } from './store/hooks';
import { LoginStatusEnum } from './store/usersSliceTypes';
import { checkLoginStatus, userLoginStatus } from './store/usersSlice';
import LoadableDocuments from './components/documents/LoadableDocuments';
import LoadableEmailValidationForm from './components/authenticate/LoadableEmailValidationForm';
import Header from './components/header/Header';
import LoadableLoginForm from './components/authenticate/LoadableLoginForm';
import LoadableLogout from './components/authenticate/LoadableLogout';
import Profile from './components/profile/Profile';
import LoadableRegistrationCompletitionForm from './components/authenticate/LoadableRegistrationCompletitionForm';
import setupCsrfToken from './services/csrfService';
import LoadableUserActivity from './components/useractivity/LoadableUserActivity';
import UserHandling from './components/UserHandling';

const { useEffect, useState } = React;

const App = () => {
  const dispatch = useAppDispatch();
  const loginStatus = useAppSelector(userLoginStatus);
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
  } else if (loginStatus === LoginStatusEnum.NOT_LOGGED_IN) {
    rootComponent = LoadableLoginForm;
  } else {
    rootComponent = LoadableDocuments;
  }

  return (
    <>
      <Router>
        <Header />
        <Switch>
          <Route exact path="/" component={rootComponent} />
          <Route exact path="/complete-registration" component={LoadableRegistrationCompletitionForm} />
          <Route exact path="/documents" component={LoadableDocuments} />
          <Route exact path="/login" component={LoadableLoginForm} />
          <Route exact path="/logout" component={LoadableLogout} />
          <Route exact path="/profile" component={Profile} />
          <Route exact path="/user-activity" component={LoadableUserActivity} />
          <Route exact path="/user-handling" component={UserHandling} />
          <Route exact path="/validate-email" component={LoadableEmailValidationForm} />
        </Switch>
      </Router>
    </>
  );
};

export default App;
