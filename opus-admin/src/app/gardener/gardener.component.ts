import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-gardener',
  templateUrl: './gardener.component.html',
  styleUrls: ['./gardener.component.css']
})
export class GardenerComponent implements OnInit {
  public data = ""
  constructor(private route: ActivatedRoute, private router: Router, private http: HttpClient) { }
  public fileName : any 
  public list : any[] = [] 
  public total  =  0 ;
  public  httpOptions = {
    headers: new HttpHeaders({
      'Content-Type':  'application/json',
    })
  };
  ngOnInit(): void {
    this.fileName  =  this.route.snapshot.paramMap.get("data");
   
    this.http.get<any>("https://selling-app-server.herokuapp.com/worker/profId/all/60a4fbbdccd3b70004c5d62b").subscribe(data => {
      this.list = data["Worker"];
      console.log(this.list);
      this.total  =  this.list.length
    });
  }

}
