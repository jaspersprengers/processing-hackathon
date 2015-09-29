import java.util.ArrayList;
import java.util.List;

public class Track {

    List<NoteEvent> noteEvents = new ArrayList<NoteEvent>();

    public void addEvent(NoteEvent noteEvent) {
        if (noteEvent != null)
            noteEvents.add(noteEvent);
    }

}
