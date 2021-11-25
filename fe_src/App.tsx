import { useEffect, useState } from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';

import { useAppDispatch, useAppSelector } from './store/hooks';
import { LoginStatusEnum } from './store/userSliceTypes';
import { checkLoginStatus, userLoginStatus } from './store/userSlice';
import Admin from './components/dashboard/Admin';
import LoadableDocuments from './components/documents/LoadableDocuments';
import LoadableEmailValidationForm from './components/authenticate/LoadableEmailValidationForm';
import LoadableLoginForm from './components/authenticate/LoadableLoginForm';
import LoadableLogout from './components/authenticate/LoadableLogout';
import LoadableProfile from './components/profile/LoadableProfile';
import LoadableRegistrationCompletitionForm from './components/authenticate/LoadableRegistrationCompletitionForm';
import LoadableUserActivity from './components/useractivity/LoadableUserActivity';
import LoadableUserHandling from './components/userhandling/LoadableUserHandling';
import Loading from './components/utils/Loading';
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
  if (!loginStatus) {
    rootComponent = <Loading />;
  } else if (loginStatus === LoginStatusEnum.NOT_LOGGED_IN) {
    rootComponent = <LoadableLoginForm />;
  } else {
    rootComponent = <Admin />;
  }

  return (
    <>
      <Router>
        <Routes>
          <Route path="/*" element={rootComponent} />
          <Route
            path="/complete-registration"
            element={<LoadableRegistrationCompletitionForm />}
          />
          <Route path="/documents" element={<LoadableDocuments />} />
          <Route path="/login" element={<LoadableLoginForm />} />
          <Route path="/logout" element={<LoadableLogout />} />
          <Route path="/profile" element={<LoadableProfile />} />
          <Route path="/user-activity" element={<LoadableUserActivity />} />
          <Route path="/user-handling" element={<LoadableUserHandling />} />
          <Route path="/validate-email" element={<LoadableEmailValidationForm />} />
        </Routes>
      </Router>
    </>
  );
};

export default App;
