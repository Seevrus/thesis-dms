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
import Dashboard from '../views/Dashboard';
import UserProfile from '../views/UserProfile';
import TableList from '../views/TableList';
import Typography from '../views/Typography';
import Icons from '../views/Icons';
import Maps from '../views/Maps';
import Notifications from '../views/Notifications';
import Upgrade from '../views/Upgrade';

const dashboardRoutes = [
  {
    upgrade: true,
    path: '/upgrade',
    name: 'Upgrade to PRO',
    icon: 'nc-icon nc-alien-33',
    component: <Upgrade />,
    layout: '',
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    icon: 'nc-icon nc-chart-pie-35',
    component: <Dashboard />,
    layout: '',
  },
  {
    path: '/user',
    name: 'User Profile',
    icon: 'nc-icon nc-circle-09',
    component: <UserProfile />,
    layout: '',
  },
  {
    path: '/table',
    name: 'Table List',
    icon: 'nc-icon nc-notes',
    component: <TableList />,
    layout: '',
  },
  {
    path: '/typography',
    name: 'Typography',
    icon: 'nc-icon nc-paper-2',
    component: <Typography />,
    layout: '',
  },
  {
    path: '/icons',
    name: 'Icons',
    icon: 'nc-icon nc-atom',
    component: <Icons />,
    layout: '',
  },
  {
    path: '/maps',
    name: 'Maps',
    icon: 'nc-icon nc-pin-3',
    component: <Maps />,
    layout: '',
  },
  {
    path: '/notifications',
    name: 'Notifications',
    icon: 'nc-icon nc-bell-55',
    component: <Notifications />,
    layout: '',
  },
];

export default dashboardRoutes;
