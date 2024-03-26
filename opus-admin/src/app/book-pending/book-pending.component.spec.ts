import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BookPendingComponent } from './book-pending.component';

describe('BookPendingComponent', () => {
  let component: BookPendingComponent;
  let fixture: ComponentFixture<BookPendingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BookPendingComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BookPendingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
