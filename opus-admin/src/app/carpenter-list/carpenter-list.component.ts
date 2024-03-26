import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-carpenter-list',
  templateUrl: './carpenter-list.component.html',
  styleUrls: ['./carpenter-list.component.css']
})
export class CarpenterListComponent implements OnInit {
  public data = ""
  constructor(private route: ActivatedRoute, private router: Router, private http: HttpClient) { }
  public fileName : any 
  public total = 0 ;
  public list : any[] = [] 
  public  httpOptions = {
    headers: new HttpHeaders({
      'Content-Type':  'application/json',
    })
  };
  ngOnInit(): void {
    this.fileName  =  this.route.snapshot.paramMap.get("data");
   
    this.http.get<any>("https://selling-app-server.herokuapp.com/worker/profId/all/609e9a426ddd8201ccfb02d0").subscribe(data => {
      this.list = data["Worker"];
      console.log(this.list);
      this.total = this.list.length;
    });
  }

}
