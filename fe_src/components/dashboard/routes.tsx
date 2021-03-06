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
import {
  __,
  contains,
  either,
  filter,
  isEmpty,
  propSatisfies,
} from 'ramda';
import { v4 as uuidv4 } from 'uuid';

import { UserPermissionsEnum } from '../../store/user/userSliceTypes';
import LoadableActivityStatistics from '../activity-statistics/LoadableActivityStatistics';
import LoadableDocuments from '../documents/LoadableDocuments';
import LoadableProfile from '../profile/LoadableProfile';
import LoadableUserActivity from '../useractivity/LoadableUserActivity';
import LoadableUserHandling from '../userhandling/LoadableUserHandling';

const dashboardRoutes = [
  {
    id: uuidv4(),
    path: '/profile',
    name: 'Profilom',
    icon: 'nc-icon nc-circle-09',
    component: <LoadableProfile />,
    layout: '',
    permission: '',
  },
  {
    id: uuidv4(),
    path: '/documents',
    name: 'Dokumentumok',
    icon: 'nc-icon nc-email-85',
    component: <LoadableDocuments />,
    layout: '',
    permission: UserPermissionsEnum.REGULAR,
  },
  {
    id: uuidv4(),
    path: '/user-activity',
    name: 'Felhasználói aktivitás',
    icon: 'nc-icon nc-notes',
    component: <LoadableUserActivity />,
    layout: '',
    permission: UserPermissionsEnum.ACTIVITY_ADMINISTRATOR,
  },
  {
    id: uuidv4(),
    path: '/activity-statistics',
    name: 'Felhasználói statisztika',
    icon: 'nc-icon nc-vector',
    component: <LoadableActivityStatistics />,
    layout: '',
    permission: UserPermissionsEnum.ACTIVITY_ADMINISTRATOR,
  },
  {
    id: uuidv4(),
    path: '/user-handling',
    name: 'Felhasználók kezelése',
    icon: 'nc-icon nc-preferences-circle-rotate',
    component: <LoadableUserHandling />,
    layout: '',
    permission: UserPermissionsEnum.USER_ADMINISTRATOR,
  },
];

const getDashboardRoutes = (userPermissions: `${UserPermissionsEnum}`[]) => filter(
  propSatisfies(
    either(
      isEmpty,
      contains(__, userPermissions),
    ), 'permission',
  ), dashboardRoutes,
);

export default getDashboardRoutes;
