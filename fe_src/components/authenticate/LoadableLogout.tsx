import * as React from 'react';
import loadable from '@loadable/component';
import Loading from '../utils/Loading';

const LoadableLogout = loadable(() => import('./Logout'), {
  fallback: <Loading />,
});

export default LoadableLogout;
