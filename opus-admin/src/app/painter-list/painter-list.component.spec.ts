import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PainterListComponent } from './painter-list.component';

describe('PainterListComponent', () => {
  let component: PainterListComponent;
  let fixture: ComponentFixture<PainterListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PainterListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PainterListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
