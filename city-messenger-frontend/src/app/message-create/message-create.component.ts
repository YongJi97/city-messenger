import { Component } from '@angular/core';
import { MessageService } from './message.service';
import { MessageListComponent } from '../message-list/message-list.component';

@Component({
  selector: 'app-message-create',
  templateUrl: './message-create.component.html',
  styleUrls: ['./message-create.component.css']
})
export class MessageCreateComponent {
  message: any = {};

  readableDate: string = "";

  constructor(private messageService: MessageService) { }

  createMessage() {
    this.message.timestamp = new Date().toISOString();
    this.messageService.createMessage(this.message).subscribe(
      (response) => {
        console.log('Message created:', response);
        this.message = {}; // Clear the form after successful creation
        this.reloadPage();


      },
      (error) => {
        console.error('Error creating message:', error);
      }
    );
  }


  reloadPage() {
    window.location.reload();
  }

}

