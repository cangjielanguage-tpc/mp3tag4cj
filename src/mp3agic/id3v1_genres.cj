/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Identification data, Qufeng.
 */
package mp3agic

/**
 * The class is ID3v1Genres
 * @since 0.31.4
 */
public class ID3v1Genres {
    /** let member GENRES type is Array<String> */
    public static let GENRES: Array<String> = [
        "Blues",
        "Classic Rock",
        "Country",
        "Dance",
        "Disco",
        "Funk",
        "Grunge",
        "Hip-Hop",
        "Jazz",
        "Metal",
        "New Age",
        "Oldies",
        "Other",
        "Pop",
        "R&B",
        "Rap",
        "Reggae",
        "Rock",
        "Techno",
        "Industrial",
        "Alternative",
        "Ska",
        "Death Metal",
        "Pranks",
        "Soundtrack",
        "Euro-Techno",
        "Ambient",
        "Trip-Hop",
        "Vocal",
        "Jazz+Funk",
        "Fusion",
        "Trance",
        "Classical",
        "Instrumental",
        "Acid",
        "House",
        "Game",
        "Sound Clip",
        "Gospel",
        "Noise",
        "Alt Rock",
        "Bass",
        "Soul",
        "Punk",
        "Space",
        "Meditative",
        "Instrumental Pop",
        "Instrumental Rock",
        "Ethnic",
        "Gothic",
        "Darkwave",
        "Techno-Industrial",
        "Electronic",
        "Pop-Folk",
        "Eurodance",
        "Dream",
        "Southern Rock",
        "Comedy",
        "Cult",
        "Gangsta",
        "Top 40",
        "Christian Rap",
        "Pop/Funk",
        "Jungle",
        "Native American",
        "Cabaret",
        "New Wave",
        "Psychedelic",
        "Rave",
        "Showtunes",
        "Trailer",
        "Lo-Fi",
        "Tribal",
        "Acid Punk",
        "Acid Jazz",
        "Polka",
        "Retro",
        "Musical",
        "Rock & Roll",
        "Hard Rock",
        "Folk",
        "Folk/Rock",
        "National Folk",
        "Swing",
        "Fast Fusion",
        "Bebob",
        "Latin",
        "Revival",
        "Celtic",
        "Bluegrass",
        "Avantgarde",
        "Gothic Rock",
        "Progressive Rock",
        "Psychedelic Rock",
        "Symphonic Rock",
        "Slow Rock",
        "Big Band",
        "Chorus",
        "Easy Listening",
        "Acoustic",
        "Humour",
        "Speech",
        "Chanson",
        "Opera",
        "Chamber Music",
        "Sonata",
        "Symphony",
        "Booty Bass",
        "Primus",
        "Porn Groove",
        "Satire/Parody",
        "Slow Jam",
        "Club",
        "Tango",
        "Samba",
        "Folklore",
        "Ballad",
        "Power Ballad",
        "Rhythmic Soul",
        "Freestyle",
        "Duet",
        "Punk Rock",
        "Drum Solo",
        "Acapella",
        "Euro-House",
        "Dance Hall",
        "Goa",
        "Drum & Bass",
        "Club-House",
        "Hardcore",
        "Terror",
        "Indie",
        "BritPop",
        "Negerpunk",
        "Polsk Punk",
        "Beat",
        "Christian Gangsta",
        "Heavy Metal",
        "Black Metal",
        "Crossover",
        "Contemporary Chr",
        "Christian Rock",
        "Merengue",
        "Salsa",
        "Thrash Metal",
        "Anime",
        "JPop",
        "Synthpop"
    ]

    private init() {}

    /**
     * The Function is matchGenreDescription, Get the sequence number corresponding to genres, Description: one of 147
     * styles in the member genres
     * 
     * @param description of String
     * 
     * @return Type of Int32
     * @since 0.31.4
     */
    public static func matchGenreDescription(description: Option<String>): Int32 {
        if (description != Option<String>.None && description.getOrThrow().size > 0) {
            var times: Int32 = 0
            for (gen in GENRES) {
                if (gen.toAsciiLower().equals(description.getOrThrow().toAsciiLower())) {
                    return times
                }
                times++
            }
        }
        return -1
    }
}
