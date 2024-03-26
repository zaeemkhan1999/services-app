import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GardenerComponent } from './gardener.component';

describe('GardenerComponent', () => {
  let component: GardenerComponent;
  let fixture: ComponentFixture<GardenerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ GardenerComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(GardenerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
