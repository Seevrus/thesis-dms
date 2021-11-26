/*!

=========================================================
* Light Bootstrap Dashboard React - v2.0.0
=========================================================

* Product Page: https://www.creative-tim.com/product/light-bootstrap-dashboard-react
* Copyright 2020 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://github.com/creativetimofficial/light-bootstrap-dashboard-react/blob/master/LICENSE.md)

* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice
shall be included in all copies or substantial portions of the Software.

*/
import * as React from 'react';
import {
  useLocation,
  useNavigate,
  Route,
  Routes,
} from 'react-router-dom';

import { useAppSelector } from '../../store/hooks';
import { EmailStatusEnum, LoginStatusEnum } from '../../store/userSliceTypes';
import { userEmailStatus, userLoginStatus } from '../../store/userSlice';

import routes from './routes';
import Loading from '../utils/Loading';
import AdminNavbar from './AdminNavbar';
import Footer from './Footer';
import Sidebar from './Sidebar';
import LoadableDocuments from '../documents/LoadableDocuments';

import sidebarImage from '../../assets/img/sidebar-4.jpg';

const { useEffect, useRef, useState } = React;

function Admin() {
  const navigate = useNavigate();

  const [isComponentLoading, setIsComponentLoading] = useState(true);

  // Redirect user is they are not supposed to be here
  const emailStatus = useAppSelector(userEmailStatus);
  const loginStatus = useAppSelector(userLoginStatus);

  useEffect(() => {
    if (!loginStatus) {
      setIsComponentLoading(true);
    } else {
      setIsComponentLoading(false);
    }

    if (loginStatus === LoginStatusEnum.NOT_LOGGED_IN) {
      navigate('/login');
    } else if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      navigate('/complete-registration');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      navigate('/validate-email');
    }
  }, [emailStatus, navigate, loginStatus]);
  // End of redirections

  const location = useLocation();
  const mainPanel = useRef(null);
  const getRoutes = (r) => r.map((prop) => {
    if (prop.layout === '') {
      return (
        <Route
          path={prop.layout + prop.path}
          element={prop.component}
          key={prop.id}
        />
      );
    }
    return null;
  });

  useEffect(() => {
    if (!isComponentLoading) {
      document.documentElement.scrollTop = 0;
      document.scrollingElement.scrollTop = 0;
      mainPanel.current.scrollTop = 0;
      if (
        window.innerWidth < 993
        && document.documentElement.className.indexOf('nav-open') !== -1
      ) {
        document.documentElement.classList.toggle('nav-open');
        const element = document.getElementById('bodyClick');
        element.parentNode.removeChild(element);
      }
    }
  }, [isComponentLoading, location]);

  if (isComponentLoading) {
    return <Loading />;
  }

  return (
    <>
      <div className="wrapper">
        <Sidebar color="black" image={sidebarImage} routes={routes} />
        <div className="main-panel" ref={mainPanel}>
          <AdminNavbar />
          <div className="content">
            <Routes>
              <Route path="/" element={<LoadableDocuments />} />
              {getRoutes(routes)}
            </Routes>
          </div>
          <Footer />
        </div>
      </div>
    </>
  );
}

export default Admin;
