import { HttpInterceptorFn } from '@angular/common/http';

/**
 * Auth interceptor — attaches the Bearer token (from localStorage) to every
 * outbound HTTP request that targets the Methy API gateway.
 */
export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const token = localStorage.getItem('access_token');

  if (token) {
    const cloned = req.clone({
      setHeaders: {
        Authorization: `Bearer ${token}`,
      },
    });
    return next(cloned);
  }

  return next(req);
};
