/* eslint-disable react/no-array-index-key */
/* eslint-disable react/jsx-props-no-spreading */
/*!

=========================================================
* Light Bootstrap Dashboard React - v2.0.0
=========================================================

* Product Page: https://www.creative-tim.com/product/light-bootstrap-dashboard-react
* Copyright 2020 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://github.com/creativetimofficial/light-bootstrap-dashboard-react/blob/master/LICENSE.md)

* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

*/
import * as React from 'react';
import { useLocation, Route, Routes } from 'react-router-dom';

import AdminNavbar from './AdminNavbar';
import Footer from './Footer';
import Sidebar from './Sidebar';
import FixedPlugin from './FixedPlugin';

import routes from './routes';

import '../../assets/css/animate.min.css';
import '../../assets/scss/light-bootstrap-dashboard-react.scss';
import '../../assets/css/demo.css';
import '@fortawesome/fontawesome-free/css/all.min.css';
import sidebarImage from '../../assets/img/sidebar-3.jpg';

const { useEffect, useRef, useState } = React;

function Admin() {
  const [image, setImage] = useState(sidebarImage);
  const [color, setColor] = useState('black');
  const [hasImage, setHasImage] = useState(true);
  const location = useLocation();
  const mainPanel = useRef(null);
  const getRoutes = (r) => r.map((prop, key) => {
    if (prop.layout === '') {
      return (
        <Route
          path={prop.layout + prop.path}
          element={prop.component}
          key={key}
        />
      );
    }
    return null;
  });
  useEffect(() => {
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
  }, [location]);
  return (
    <>
      <div className="wrapper">
        <Sidebar color={color} image={hasImage ? image : ''} routes={routes} />
        <div className="main-panel" ref={mainPanel}>
          <AdminNavbar />
          <div className="content">
            <Routes>{getRoutes(routes)}</Routes>
          </div>
          <Footer />
        </div>
      </div>
      <FixedPlugin
        hasImage={hasImage}
        setHasImage={() => setHasImage(!hasImage)}
        color={color}
        setColor={setColor}
        image={image}
        setImage={setImage}
      />
    </>
  );
}

export default Admin;
