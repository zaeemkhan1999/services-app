import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-book-confirm',
  templateUrl: './book-confirm.component.html',
  styleUrls: ['./book-confirm.component.css']
})
export class BookConfirmComponent implements OnInit {
  public data = ""
  constructor(private route: ActivatedRoute, private router: Router, private http: HttpClient) { }
  public fileName : any 
  public list : any[] = [] 
  public total = 0 
  public  httpOptions = {
    headers: new HttpHeaders({
      'Content-Type':  'application/json',
    })
  };
  ngOnInit(): void {
   
    this.http.get<any>("https://selling-app-server.herokuapp.com/booking/book/client/confirm/all/admin").subscribe(data => {
      this.list = data["Booking"];
      console.log(this.list);
      this.total  =  this.list.length;
    });
  }


}
