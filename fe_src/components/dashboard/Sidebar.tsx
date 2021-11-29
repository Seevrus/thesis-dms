/* eslint-disable react/prop-types */
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
import { NavLink, useLocation, useNavigate } from 'react-router-dom';
import { Nav } from 'react-bootstrap';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { checkLoginStatus, loginExpires } from '../../store/userSlice';

import logo from '../../assets/img/reactlogo.png';

function Sidebar({ color, image, routes }) {
  const dispatch = useAppDispatch();
  const location = useLocation();
  const navigate = useNavigate();
  const activeRoute = (routeName) => (location.pathname.indexOf(routeName) > -1 ? 'active' : '');

  const expires = useAppSelector(loginExpires);

  if (expires) {
    const idleCheck = setInterval(() => {
      if ((expires * 1000 - Date.now() < 0)) {
        clearInterval(idleCheck);
        navigate('/logout');
      }
    }, 5000);
  }

  const recordActivity = () => dispatch(checkLoginStatus());

  return (
    <div className="sidebar" data-image={image} data-color={color}>
      <div
        className="sidebar-background"
        style={{
          backgroundImage: `url(${image})`,
        }}
      />
      <div className="sidebar-wrapper">
        <div className="logo d-flex align-items-center justify-content-start">
          <div className="logo-img">
            <img
              src={logo}
              alt="..."
            />
          </div>
          <span className="simple-text">
            Thesis-DMS
          </span>
        </div>
        <Nav>
          {routes.map((prop) => {
            if (!prop.redirect) {
              return (
                <li
                  className={
                    prop.upgrade
                      ? 'active active-pro'
                      : activeRoute(prop.layout + prop.path)
                  }
                  key={prop.id}
                >
                  <NavLink
                    onClick={recordActivity}
                    to={prop.layout + prop.path}
                    // eslint-disable-next-line arrow-body-style
                    className={({ isActive }) => {
                      return isActive ? 'nav-link active' : 'nav-link';
                    }}
                  >
                    <i className={prop.icon} />
                    <p>{prop.name}</p>
                  </NavLink>
                </li>
              );
            }
            return null;
          })}
        </Nav>
      </div>
    </div>
  );
}

export default Sidebar;
