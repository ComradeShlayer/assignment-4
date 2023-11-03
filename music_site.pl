
% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: 
%%%%% NAME:
%%%%% NAME:
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: constants
%%%%% You do not have to add anything to this section, but feel free to change the currentYear value to test your program

orderNames([first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, 
            eleventh, twelfth, thirteenth, fourteenth, fifteenth, sixteenth, seventeenth, eighteenth, nineteenth, twentytieth]).

currentYear(2023).

%%%%% SECTION: database
%%%%% Put statements for albumArtist, albumYear, albumGenre, and trackList below
albumArtist(thriller, micheal_jackson).
albumArtist(hotel_california, eagles).
albumArtist(rumours, fleetwood_mac).
albumArtist(marshall_matters, eminem).
albumArtist(no_string_attached, nsync).
albumArtist(the_eminem_show, eminem).
albumArtist(all_the_right_reasons, nickleback).
albumArtist(fearless, taylor_swift).
albumArtist(speakerboxxx, outkast).
albumArtist(hamilton, cast_recording).

albumYear(thriller, 1982).
albumYear(hotel_california, 1976).
albumYear(rumours, 1977).
albumYear(marshall_matters, 2000).
albumYear(no_string_attached, 2000).
albumYear(the_eminem_show, 2002).
albumYear(all_the_right_reasons, 2005).
albumYear(fearless, 2008).
albumYear(speakerboxxx, 2003).
albumYear(hamilton, 2015).

albumGenre(thriller, disco).
albumGenre(thriller, pop).
albumGenre(hotel_california, rock).
albumGenre(rumours, alternative).
albumGenre(rumours, rock).
albumGenre(rumours, folk).
albumGenre(marshall_matters, rap).
albumGenre(no_string_attached, pop).
albumGenre(the_eminem_show, rap).
albumGenre(all_the_right_reasons, rock).
albumGenre(fearless, pop).
albumGenre(speakerboxxx, rap).
albumGenre(speakerboxxx, hip_hop).
albumGenre(hamilton, theater).
albumGenre(hamilton, musical).

trackList(thriller, [song(the_girl_is_mine, 222), song(baby_be_mine, 260), song(human_nature, 246), song(pretty_young_thing, 237)]).
trackList(hotel_california, [song(hotel_california, 390), song(new_kid_in_town, 304), song(life_in_the_fastlan, 286), song(wasted_time, 295), song(victim_of_love, 251)]).
trackList(rumours, [song(the_chain, 270), song(i_dont_want_to_know, 195), song(songbird, 201), song(oh_daddy, 236)]).
trackList(marshall_matters, [song(bitch_please_ii, 288), song(remember_me, 218), song(amityville, 255), song(stan, 404), song(kim, 378), song(under_the_influence, 322), song(the_way_i_am, 290), song(im_back, 310)]).
trackList(no_string_attached, [song(bye_bye_bye, 199), song(its_gonna_be_me, 191), song(space_cowboy, 261)]).
trackList(the_eminem_show, [song(till_i_collapse, 300), song(say_what_you_say, 310), song(superman, 350)]).
trackList(all_the_right_reasons, [song(savin_me, 218), song(animals, 187), song(rockstar, 255), song(photograph, 259)]).
trackList(fearless, [song(breathe, 264), song(you_belong_with_me, 231), song(the_way_i_loved_you, 245)]).
trackList(speakerboxxx, [song(bust, 189), song(bowtie, 236), song(reset, 276)]).
trackList(hamilton, [song(alexander_hamilton, 236), song(aaron_burr_sir, 156), song(my_shot, 333)]).

%%%%% SECTION: helpers
%%%%% Add the predicates isSong(Song), songLength(Song, Length), onAlbum(Song, Album), albumLength(Album, Length), and atNamedIndex(List, Entry, Element)
%%%%% Another other helper predicates you wish to add for your lexicon or the parser should be added here
isSong(Song) :-
   trackList(_, Tracklist),
   member(song(Song, _), Tracklist).

songLength(Song, Length) :-
   trackList(_, Tracklist),
   member(song(Song, Length), Tracklist).

onAlbum(Song, Album) :-
   trackList(Album, Tracklist),
   member(song(Song, _), Tracklist).

albumLength(Album, Length) :-
   trackList(Album, Tracklist),
   albumLengthHelper(Tracklist, 0, Length).

albumLengthHelper([], Length, Length).
albumLengthHelper([song(_, Length) | Rest], Acc, Total) :-
   Temp is Acc + Length,
   albumLengthHelper(Rest, Temp, Total).

%%%%% SECTION: articles
%%%%% Put the rules/statements defining the proper_nouns below



%%%%% SECTION: proper_nouns
%%%%% Put the rules/statements defining the proper_nouns below



%%%%% SECTION: common_nouns
%%%%% Put the rules/statements defining the common_nouns below



%%%%% SECTION: adjectives
%%%%% Put the rules/statements defining the adjectives below



%%%%% SECTION: prepositions
%%%%% Put the rules/statements defining the prepositions below



%%%%% SECTION: PARSER
%%%%% For testing your lexicon for question 3, we will use the default parser initially given to you.
%%%%% For testing your answers for question 4, we will use your parser below

what(Words, Ref) :- np(Words, Ref).

/* Noun phrase can be a proper name or can start with an article */

np([Name],Name) :- proper_noun(Name).
np([Art|Rest], What) :- article(Art), np2(Rest, What).


/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */

np2([Adj|Rest],What) :- adjective(Adj,What), np2(Rest, What).
np2([Noun|Rest], What) :- common_noun(Noun, What), mods(Rest,What).

/* Modifier(s) provide an additional specific info about nouns.
   Modifier can be a prepositional phrase followed by none, one or more
   additional modifiers.  */

mods([], _).
mods(Words, What) :-
	appendLists(Start, End, Words),
	prepPhrase(Start, What),	mods(End, What).

prepPhrase([Prep|Rest], What) :-
	preposition(Prep, What, Ref), np(Rest, Ref).

appendLists([], L, L).
appendLists([H|L1], L2, [H|L3]) :-  appendLists(L1, L2, L3).

