//
//  Contants.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/09/2021.
//

import Foundation
import UIKit
import CoreData
import SwiftUI



struct Constants {
    
    static let honeyBadgerText: String = """
The honey badger is one of the toughest mammals in Africa and western Asia. They are only about 60 centimeters long, and they weigh just over 9 kilograms. Yet they have a reputation for toughness that is far greater than their size. Some honey badgers will chase away lions and take their kills. I guess that goes to show you that size isn't the only thing that matters in a fight.

So what makes the honey badger so tough? They have speed, stamina, and agility, but so do many animals. They aren't stronger than lions, so how do they stop them? The thing that sets the honey badger apart is their skin. Their skin is thick and tough. Arrows, spears, and bites from other animals can rarely pierce it. Small bullets can't even penetrate it. Not only is their skin thick and tough, it is also loose. This allows them to twist and turn to attack while another animal is gripping them. The only safe grip one can get on a honey badger is on the back of their necks.

Honey badgers have long, sharp claws. These claws are good for attacking and even better for digging. Honey badgers are some of nature's most skilled diggers. They can dig a nine-foot tunnel into hard ground in about 10 minutes. They love to catch a meal by digging up the burrows of frogs, rodents, and cobras. They also use their digging skills to create their homes. They live in small chambers in the ground and defend them fiercely. They will attack horses, cows, and even water buffalo if they are foolish enough to poke around a honey badger's den.

You don't get a reputation like the honey badger by running from danger. The honey badger is fearless and a tireless fighter. They will attack any creature that threatens them, man included. Because of the honey badger's reputation, most predators avoid them. Some animals use the honey badger's rep to their advantage. Adult cheetahs have spotted coats, but their kittens have silver manes and look like honey badgers. Some scientists believe that their coloring tricks predators into avoiding them. Wouldn't you walk the other way if you saw a honey badger?

You might be wondering: "If honey badgers are so tough, how did they get a name that makes them sound like a piece of candy?" The answer makes sense. Since honey badgers have such thick skin, bee stings rarely harm them. So honey badgers love to raid beehives. Honey badgers chase after honey aggressively. So much so that beekeepers in Africa have to use electric fencing to hold them back.

Beekeepers aren't the only people who have grown to hate honey badgers. Honey badgers may be fun to read about, but they are nasty neighbors. They attack chickens, livestock, and some say children, though they usually leave people alone. But if a honey badger moves in your backyard, there's not a whole lot that you can do about it. I mean, are you going to go and tangle with an animal that eats the bones of its prey? An animal with teeth strong enough to crunch through turtle shells? An animal that never tires, gives up, or backs down? Yeah, I wouldn't either...
"""
    
    static let dodoText: String = """
Many plants and animals went extinct due to human activity. Few are as well known as the dodo. You may have heard that humans hunted them to the point of extinction. Legends and folktales do not tell the whole story.

The only place the dodo ever lived was the island of Mauritius. Mauritius is smaller than Rhode Island. It is off the coast of Madagascar, a much larger island east of Africa. There were no mammals on Mauritius before humans arrived. The dodo descended from pigeons that had flown to Mauritius. These pigeons found that this island had clean water and lots of fruit. Also, no predators lived there. They could relax and live in peace. Over millions of years, they evolved to become big and flightless. They became dodos.

Humans discovered Mauritius during the Age of Exploration. The Dutch colonized the island in 1638. They tried to farm and settle the land. They wanted to produce exports. They wanted the island to be more like their homes in the Netherlands. They brought pigs, chickens, cats, and other animals, even deer. They also brought the rats that hid on their ships.

The colonists hunted and ate many dodos. The birds had never faced predators. They were not stupid though. They learned to run from humans. They might have even adapted and survived, if it weren't for the other new mammals on Mauritius. The cats and rats ate the dodos' eggs. Since dodos could not fly, they were unable to hide their eggs in trees like other birds. The new pigs, chickens, and livestock on the island now competed with the dodos for food. The dodos had to go deeper and deeper into the forests of Mauritius to survive. At the same time, the colonists were clearing the forests to make farmland. This total ecological attack was too much for these great birds.

The last recorded encounter with a dodo happened in 1662. A shipwrecked sailor wrote that he and his friends had caught a dodo. He said that the bird made a great noise and all the bird's friends ran to assist it. The men then captured them all.

No one noticed the extinction of the dodo when it happened. The concept didn't even exist at the time. The word "extinction" wouldn't even be used in that way for another 100 years. People just weren't aware of their impact on the environment. They didn't know about the delicate balance of life. The Dutch abandoned Mauritius in 1710. The dodo was not the only animal that was wiped out. It was only the most popular. Hundreds of plants and animals from Mauritius are now gone due to human activity.
"""

    
//    static let wpmComprehensionQuestions: [(String, [String])] = [
//        ("Compared to average reader, the accomplished reader reads with?", ["higher speed and worse reading comprehension", "higher speed and better reading comprehension", "higher speed and same reading comprehension"]),
//        ("Readers reading above 1000 wpm", ["Are average readers","Are the majority of readers","Are the 1 % minority"]),
//        ("The average reading speed is around?", ["120 wpm","150 wpm","200 wpm"])
//    ]
    
    static let honeyBadgerQuestions: [Question] = [Question(question: "Which statement would the author most likely agree with?", optionA: "Honey badgers are very strong.", optionB: "Honey badgers are large in size.", optionC: "Honey badgers have thick and loose skin.", optionD: "Honey badgers mainly eats plants.", answer: "Honey badgers have thick and loose skin."),
                                        
                                        Question(question: "Which statement would the author most likely disagree with?", optionA: "Honey badgers like to to eat honey.", optionB: "Honey badgers might be the toughest animal.", optionC: "Honey badgers disguise their young to look like cheetah kittens.", optionD: "Honey badgers are not afraid to fight with humans.", answer: "Honey badgers disguise their young to look like cheetah kittens."),
                                        
                                        Question(question: "Which animal is the honey badger afraid to attack?", optionA: "Lions", optionB: "Snakes", optionC: "Water buffalos", optionD: "None of these", answer: "None of these"),
                                        
                                        Question(question: "Which is not one of the honey badger's strengths?", optionA: "Thick skin", optionB: "Powerful jaws and strong teeth", optionC: "Tireless fighting spirit", optionD: "Poisonous bite", answer: "Poisonous bite"),
                                        
                                        Question(question: "How did the honey badger get its name?", optionA: "From the sweet taste of their meat.", optionB: "Because of their fondness for feeding on honey.", optionC: "Because they would often steal honey from beekeepers.", optionD: "Because the white part of their fur turns yellow during the summer", answer: "Because of their fondness for feeding on honey."),
                                        
                                        Question(question: "Honey badgers can be found in Africa and", optionA: "Southern Europe", optionB: "South America", optionC: "Western Asia", optionD: "South-East Asia", answer: "Western Asia")
    ]
    
    static let dodoQuestions: [Question] = [Question(question: "Which bird is an ancestor of the dodo?", optionA: "The penguin", optionB: "The pigeon", optionC: "The chicken", optionD: "The ostrich", answer: "The pigeon"),
                                        
                                        Question(question: "Which best explains WHY dodos lost the ability to fly?", optionA: "The forest was so dense in Mauritius that birds couldn't fly.", optionB: "Dodo wings adapted to swimming, like penguins.", optionC: "The dodos had no predators on Mauritius.", optionD: "Mauritius was too windy and flying there was dangerous.", answer: "The dodos had no predators on Mauritius."),
                                        
                                        Question(question: "Which was NOT a factor in the extinction of the dodo?", optionA: "Pigs and chickens out-competed the dodo for food.", optionB: "Cats and rats ate the dodos' eggs", optionC: "Humans cleared forestland to make farmland.", optionD: "Pollution spoiled the dodos' ancient mating grounds.", answer: "Pollution spoiled the dodos' ancient mating grounds."),
                                        
                                        Question(question: "Which statement is TRUE based on information from the text?", optionA: "Overhunting was the sole cause of the dodo's extinction.", optionB: "The Dutch colonies on Mauritius were a great success.", optionC: "The dodo was the only species extinguished by the colonists.", optionD: "Mauritius is the only place the dodo has ever lived", answer: "Mauritius is the only place the dodo has ever lived"),
                                        
                                        Question(question: "How did people feel about the extinction of the dodo when it happened?", optionA: "Many people were really upset.", optionB: "Animal protection groups were formed.", optionC: "Most people didn't notice or care.", optionD: "Governments started preserving wildlife.", answer: "Most people didn't notice or care."),
                                        
                                        Question(question: "Which statement is FALSE?", optionA: "Mauritius had a lot of fruit trees in the past.", optionB: "Mauritius is off the coast of Brazil.", optionC: "Mauritius is a small island.", optionD: " Mauritius had no mammals on it for most of time.", answer: "Mauritius is off the coast of Brazil.")
    ]
    
    
    
    static let dummyText: String = "Obsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dear. Obsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dearObsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dear. Obsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dearObsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dear. Obsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dear"
    
    static let initialText: [String] = []
    
//    var books: [Book] = [Book(title: "Frankenstein", author: "Mary Shelley", img: UIImage(named: "Frankenstein_Or_The_Modern_Prometheus"), text: "sksksks", about: "Obsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dear.", category: "Fiction")]


    
}
