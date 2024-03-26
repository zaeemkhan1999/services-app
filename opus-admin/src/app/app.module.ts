import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { NbActionsModule, NbButtonModule, NbCardModule, NbCheckboxModule, NbIconModule, NbInputModule, NbLayoutModule, NbListModule, NbMenuModule, NbSidebarModule, NbSpinnerModule, NbTabsetModule, NbThemeModule, NbUserModule } from '@nebular/theme';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NbEvaIconsModule } from '@nebular/eva-icons';
import { RootComponent } from './root/root.component';
import { CarpenterListComponent } from './carpenter-list/carpenter-list.component';
import { ElectricianListComponent } from './electrician-list/electrician-list.component';
import { PlumberListComponent } from './plumber-list/plumber-list.component';
import { GardenerComponent } from './gardener/gardener.component';
import { MasonryComponent } from './masonry/masonry.component';
import { PainterListComponent } from './painter-list/painter-list.component';
import { ACListComponent } from './ac-list/ac-list.component';
import { CCTVListComponent } from './cctv-list/cctv-list.component';
import { HttpClientModule } from '@angular/common/http';
import { BookConfirmComponent } from './book-confirm/book-confirm.component';
import { BookHistoryComponent } from './book-history/book-history.component';
import { BookPendingComponent } from './book-pending/book-pending.component';
import { ClientListComponent } from './client-list/client-list.component';

@NgModule({
  declarations: [
    AppComponent,
    RootComponent,
    CarpenterListComponent,
    ElectricianListComponent,
    PlumberListComponent,
    GardenerComponent,
    MasonryComponent,
    PainterListComponent,
    ACListComponent,
    CCTVListComponent,
    BookConfirmComponent,
    BookHistoryComponent,
    BookPendingComponent,
    ClientListComponent,

    
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserModule,
    AppRoutingModule,
    NbSpinnerModule,
    FormsModule,
    ReactiveFormsModule,
    NbThemeModule.forRoot({ name: 'custom-theme' }),
    NbLayoutModule,
    NbCardModule,
    NbIconModule,
    NbLayoutModule ,
    NbSidebarModule.forRoot(),
    NbListModule,
    NbCheckboxModule,
    NbButtonModule,
    NbMenuModule.forRoot(),
    NbLayoutModule,
    NbTabsetModule,
    NbActionsModule,    
    NbInputModule,
    NbUserModule,
    BrowserAnimationsModule,
    NbThemeModule.forRoot({ name: 'default' }),
    NbEvaIconsModule,
    HttpClientModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
