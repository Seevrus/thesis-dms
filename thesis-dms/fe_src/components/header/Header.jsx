import React from 'react';
import { useSelector } from 'react-redux';

import { isUserLoggedin, LOGIN_STATUS } from '../../store/usersSlice';
import NavigationBar from './NavigationBar';

const Header = () => {
  const loggedin = useSelector(isUserLoggedin);

  let navBarComponent;
  if (loggedin === null) {
    navBarComponent = null;
  } else if (loggedin === LOGIN_STATUS.NOT_LOGGED_IN) {
    navBarComponent = <NavigationBar />;
  } else {
    navBarComponent = <NavigationBar />; // TODO: import navbar here
  }

  return (
    <div className="container mt-5 mb-5">
      <div className="d-flex">
        <div className="col-3 align-self-center">
          <h3 className="text-center">Logó helye</h3>
        </div>
        <div className="col-8 align-self-center">
          <h3 className="text-center">Szentistváni Mezőgazdasági Zrt.</h3>
        </div>
      </div>
      {navBarComponent}
    </div>
  );
};

export default Header;
