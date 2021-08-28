import * as React from 'react';
import loadable from '@loadable/component';
import Loading from '../utils/Loading';

const LoadableRegistrationCompletitionForm = loadable(() => import('./RegistrationCompletitionForm'), {
  fallback: <Loading />,
});

export default LoadableRegistrationCompletitionForm;
