import { useEffect, useState } from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import { useAppDispatch, useAppSelector } from './store/hooks';
import { LoginStatusEnum } from './store/userSliceTypes';
import { checkLoginStatus, userLoginStatus } from './store/userSlice';
import LoadableDocuments from './components/documents/LoadableDocuments';
import LoadableEmailValidationForm from './components/authenticate/LoadableEmailValidationForm';
import Header from './components/header/Header';
import LoadableLoginForm from './components/authenticate/LoadableLoginForm';
import LoadableLogout from './components/authenticate/LoadableLogout';
import LoadableProfile from './components/profile/LoadableProfile';
import LoadableRegistrationCompletitionForm from './components/authenticate/LoadableRegistrationCompletitionForm';
import LoadableUserActivity from './components/useractivity/LoadableUserActivity';
import LoadableUserHandling from './components/userhandling/LoadableUserHandling';
import setupCsrfToken from './services/csrfService';

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
          <Route exact path="/profile" component={LoadableProfile} />
          <Route exact path="/user-activity" component={LoadableUserActivity} />
          <Route exact path="/user-handling" component={LoadableUserHandling} />
          <Route exact path="/validate-email" component={LoadableEmailValidationForm} />
        </Switch>
      </Router>
    </>
  );
};

export default App;
