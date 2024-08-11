/*
Copyright © 2024 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/spf13/cobra"
	tele "gopkg.in/telebot.v3"
)

var TeleToken = os.Getenv("TELE_TOKEN")

// gobotCmd represents the gobot command
var gobotCmd = &cobra.Command{
	Use:     "gobot",
	Aliases: []string{"start", "run", "go"},
	Short:   "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Printf("gobot v%s started", version)
		bot, err := tele.NewBot(tele.Settings{
			URL:    "",
			Token:  TeleToken,
			Poller: &tele.LongPoller{Timeout: 10 * time.Second},
		})
		if err != nil {
			log.Fatal(err)
		}
		bot.Handle(tele.OnText, func(c tele.Context) error {
			return c.Reply("Hello, " + c.Sender().FirstName + "!" + " I'm a gobot, v" + version + "!\nYou've asked me: " + c.Text())
		})

		bot.Start()

		fmt.Printf("gobot v%s stopped", version)
	},
}

func init() {
	rootCmd.AddCommand(gobotCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// gobotCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// gobotCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
