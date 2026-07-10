import Component from "@glimmer/component";
import dConcatClass from "discourse/ui-kit/helpers/d-concat-class";
import dFormatDate from "discourse/ui-kit/helpers/d-format-date";

export default class TopicActivityColumn extends Component {
  get topicUser() {
    const bumpedLastPostedDaysDiff = moment
      .duration(
        moment(this.args.topic.bumped_at).diff(
          moment(this.args.topic.last_posted_at)
        )
      )
      .asDays();

    if (
      moment(this.args.topic.bumped_at).isAfter(
        this.args.topic.last_posted_at
      ) &&
      bumpedLastPostedDaysDiff > 1
    ) {
      return {
        username: undefined,
        class: "--updated",
      };
    }

    if (this.args.topic.posts_count > 1) {
      return {
        username: this.args.topic.last_poster_username,
        class: "--replied",
      };
    } else if (this.args.topic.posts_count === 1) {
      return {
        username: this.args.topic.last_poster_username,
        class: "--created",
      };
    } else {
      return;
    }
  }

  <template>
    <span class={{dConcatClass "topic-activity" this.topicUser.class}}>
      {{#if this.topicUser.username}}
        <span
          class="topic-activity__username"
        >{{this.topicUser.username}}</span>
        <span class="dot-separator"></span>
      {{/if}}
      <div class="topic-activity__time">
        {{dFormatDate @topic.bumpedAt leaveAgo="true" format="tiny"}}
      </div>
    </span>
  </template>
}
