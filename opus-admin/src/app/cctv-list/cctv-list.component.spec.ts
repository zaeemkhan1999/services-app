import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CCTVListComponent } from './cctv-list.component';

describe('CCTVListComponent', () => {
  let component: CCTVListComponent;
  let fixture: ComponentFixture<CCTVListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CCTVListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CCTVListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
