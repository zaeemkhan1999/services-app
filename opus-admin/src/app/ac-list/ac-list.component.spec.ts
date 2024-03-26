import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ACListComponent } from './ac-list.component';

describe('ACListComponent', () => {
  let component: ACListComponent;
  let fixture: ComponentFixture<ACListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ACListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ACListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
