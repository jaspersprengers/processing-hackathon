
public class NoteEvent {

    int value;
    int time;
    int velocity;

    public NoteEvent(final String value, final String time, final String velocity) {
        this.value = Integer.parseInt(value);
        this.time = Integer.parseInt(time);
        this.velocity = Integer.parseInt(velocity);
    }

    public String toString() {
        return String.format("%d|%d|%d", time, value, velocity);
    }

}
