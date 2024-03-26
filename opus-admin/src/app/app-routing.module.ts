import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ACListComponent } from './ac-list/ac-list.component';
import { BookConfirmComponent } from './book-confirm/book-confirm.component';
import { BookHistoryComponent } from './book-history/book-history.component';
import { BookPendingComponent } from './book-pending/book-pending.component';
import { CarpenterListComponent } from './carpenter-list/carpenter-list.component';
import { CCTVListComponent } from './cctv-list/cctv-list.component';
import { ClientListComponent } from './client-list/client-list.component';
import { ElectricianListComponent } from './electrician-list/electrician-list.component';
import { GardenerComponent } from './gardener/gardener.component';
import { MasonryComponent } from './masonry/masonry.component';
import { PainterListComponent } from './painter-list/painter-list.component';
import { PlumberListComponent } from './plumber-list/plumber-list.component';
import { RootComponent } from './root/root.component';

const routes: Routes = [
  
  { path: "", component: RootComponent, children: [
    { path: "carpenter", component:  CarpenterListComponent, },
    { path: "electrician", component: ElectricianListComponent, },
    { path: "plumber", component: PlumberListComponent, },
    { path: "garderner", component: GardenerComponent, },
    { path: "masonry", component: MasonryComponent, },
    { path: "painter", component: PainterListComponent, },
    { path: "ac", component: ACListComponent, },
    { path: "cctv", component: CCTVListComponent, },
    { path: "booking-confirm", component: BookConfirmComponent, },
    { path: "booking-pending", component: BookPendingComponent, },
    { path: "booking-history", component: BookHistoryComponent, },
    { path: "client", component: ClientListComponent, },
  ]},

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
