import org.apache.commons.io.FileUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class Parser {

    public void parse(File fXmlFile) throws Exception {

        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        Document doc = dBuilder.parse(fXmlFile);
        //optional, but recommended
        doc.getDocumentElement().normalize();
        List<Track> tracks = parseTracks(doc.getElementsByTagName("Track"));
        for (Track track : tracks) {
            for (NoteEvent event : track.noteEvents) {
                System.out.println(event);
            }
        }

    }

    private List<Track> parseTracks(NodeList trackNodes) {
        List<Track> tracks = new ArrayList<Track>();
        for (int temp = 0; temp < trackNodes.getLength(); temp++) {
            Node nNode = trackNodes.item(temp);
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                Element trackElement = (Element) nNode;
                tracks.add(parseEvents(new Track(), trackElement.getElementsByTagName("Event")));
            }
        }
        return tracks;
    }

    private Track parseEvents(Track track, NodeList events) {
        for (int temp = 0; temp < events.getLength(); temp++) {
            Node nNode = events.item(temp);
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                NoteEvent noteEvent = extractNoteEvent((Element) nNode);
                track.addEvent(noteEvent);
            }
        }
        return track;
    }

    private NoteEvent extractNoteEvent(Element element) {
        NodeList timeEls = element.getElementsByTagName("Absolute");
        String time = null;
        String noteValue = null;
        String velocity = null;
        if (timeEls != null && timeEls.getLength() == 1) {
            time = timeEls.item(0).getFirstChild().getTextContent();
        }
        NodeList noteOnEls = element.getElementsByTagName("NoteOn");
        if (noteOnEls != null && noteOnEls.getLength() == 1) {
            Element noteOnEl = (Element) noteOnEls.item(0);
            noteValue = noteOnEl.getAttribute("Note");
            velocity = noteOnEl.getAttribute("Velocity");
        }
        if (time != null && velocity != null && noteValue != null) {
            return new NoteEvent(noteValue, time, velocity);
        } else {
            return null;
        }
    }


}
