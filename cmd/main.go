package cmd

import (
	"fmt"
	"os"
	"typeform/app"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "typeform",
	Short: "Typeform test task",
	Long:  "Webserver which returns a simple answer",
	Run: func(cmd *cobra.Command, args []string) {
		port, _ := cmd.Flags().GetString("port")
		debug, _ := cmd.Flags().GetBool("debug")
		if port == "" {
			port = "8765"
		}
		app.RunServer(port, debug)
	},
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
func init() {
	cobra.OnInitialize()
	rootCmd.PersistentFlags().String("port", "8765", "Web server port")
	rootCmd.PersistentFlags().Bool("debug", false, "Enable for GIN")
}
