import { inject } from '@angular/core';
import { CanActivateFn, CanMatchFn, Router } from '@angular/router';

/**
 * Auth guard — prevents unauthenticated users from activating or matching
 * protected routes. Redirects to /login if no token is present.
 */
export const authGuard: CanActivateFn = (_route, _state) => {
  const router = inject(Router);
  const token = localStorage.getItem('access_token');

  if (token) {
    return true;
  }

  return router.createUrlTree(['/login']);
};

export const authMatchGuard: CanMatchFn = (_route, _segments) => {
  const router = inject(Router);
  const token = localStorage.getItem('access_token');

  if (token) {
    return true;
  }

  return router.createUrlTree(['/login']);
};
