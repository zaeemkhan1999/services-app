import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PlumberListComponent } from './plumber-list.component';

describe('PlumberListComponent', () => {
  let component: PlumberListComponent;
  let fixture: ComponentFixture<PlumberListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PlumberListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PlumberListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
