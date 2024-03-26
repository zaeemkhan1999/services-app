import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CarpenterListComponent } from './carpenter-list.component';

describe('CarpenterListComponent', () => {
  let component: CarpenterListComponent;
  let fixture: ComponentFixture<CarpenterListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CarpenterListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CarpenterListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
