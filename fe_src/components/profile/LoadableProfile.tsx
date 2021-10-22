import * as React from 'react';
import loadable from '@loadable/component';
import Loading from '../utils/Loading';

const LoadableProfile = loadable(() => import('./Profile'), {
  fallback: <Loading />,
});

export default LoadableProfile;
