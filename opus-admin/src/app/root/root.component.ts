import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { NbMenuItem, NbSidebarService } from '@nebular/theme';

@Component({
  selector: 'app-root',
  templateUrl: './root.component.html',
  styleUrls: ['./root.component.css']
})
export class RootComponent implements OnInit {
  public root: boolean = false;
  items: NbMenuItem[] = [
    {
      title: 'Service Providers List',
      expanded: false,
      icon : 'keypad-outline',
      
      children: [
        {
          title: 'Electrician',
          icon: 'person-outline',
          link:'/electrician'
        },
        {
          title: 'Carpenter',
          icon: 'person-outline',
          link:'/carpenter'
        },
        {
          title: 'Plumber',
          icon: 'person-outline',
          link:'/plumber'
        },
        {
          title: 'Gardener',
          icon: 'person-outline',
          link:'/garderner'
        },
        {
          title: 'Masonry',
          icon: 'person-outline',
          link:'/masonry'
        },
        {
          title: 'Painter',
          icon: 'person-outline',
          link:'/painter'
        },
        {
          title: 'AC Technician',
          icon: 'person-outline',
          link:'/ac'
        },
        {
          title: 'CCTV',
          icon: 'person-outline',
          link:'/cctv'
        },
      ],
    },
    {
      title: 'Booking List',
      expanded: false,
      icon : 'trending-up-outline',
      
      children: [
        {
          title: 'Booking Confirm',
          icon: 'keypad-outline',
          link:'/booking-confirm'
        },
        {
          title: 'Booking Pending',
          icon: 'keypad-outline',
          link:'/booking-pending'
        },
        {
          title: 'Booking history',
          icon: 'keypad-outline',
          link:'/booking-history'
        },
      ]
    },
    
   {
    title: 'Clinet List',
    expanded: false,
    icon : 'keypad-outline',
    link:'/client'
   }
    
    
  ];
  value = '';
  constructor(
    private router : Router, 
    private sidebar : NbSidebarService
  ) { }

  ngOnInit(): void { }

  toggle() {
    this.sidebar.toggle(true, 'left');
  }
}


