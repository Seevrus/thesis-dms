import * as React from 'react';
import loadable from '@loadable/component';
import Loading from '../utils/Loading';

const LoadableUserActivity = loadable(() => import('./UserActivity'), {
  fallback: <Loading />,
});

export default LoadableUserActivity;
