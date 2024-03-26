import { HttpHeaders, HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-book-pending',
  templateUrl: './book-pending.component.html',
  styleUrls: ['./book-pending.component.css']
})
export class BookPendingComponent implements OnInit {
  public data = ""
  constructor(private route: ActivatedRoute, private router: Router, private http: HttpClient) { }
  public fileName : any 
  public list : any[] = [] 
  public total = 0  ; 
  public  httpOptions = {
    headers: new HttpHeaders({
      'Content-Type':  'application/json',
    })
  };
  ngOnInit(): void {
   
    this.http.get<any>("https://selling-app-server.herokuapp.com/booking/book/client/pending/all/admin").subscribe(data => {
      this.list = data["Booking"];
      console.log(this.list);
      this.total  =  this.list.length
    });
  }

}
