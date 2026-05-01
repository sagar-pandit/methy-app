import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: 'restaurants',
    loadComponent: () =>
      import('./features/restaurants/restaurants.page').then((m) => m.RestaurantsPage),
  },
  {
    path: 'orders',
    loadComponent: () => import('./features/orders/orders.page').then((m) => m.OrdersPage),
  },
  {
    path: 'delivery',
    loadComponent: () => import('./features/delivery/delivery.page').then((m) => m.DeliveryPage),
  },
  {
    path: 'admin',
    loadComponent: () => import('./features/admin/admin.page').then((m) => m.AdminPage),
  },
  {
    path: 'profile',
    loadComponent: () => import('./features/profile/profile.page').then((m) => m.ProfilePage),
  },
  {
    path: '',
    pathMatch: 'full',
    redirectTo: 'restaurants',
  },
];
