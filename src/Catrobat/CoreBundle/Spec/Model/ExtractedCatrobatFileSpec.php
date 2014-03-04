<?php

namespace Catrobat\CoreBundle\Spec\Model;

use PhpSpec\ObjectBehavior;
use Prophecy\Argument;

class ExtractedCatrobatFileSpec extends ObjectBehavior
{
  function let()
  {
    $this->shouldThrow('Catrobat\CoreBundle\Exceptions\InvalidCatrobatFileException')->during('__construct', array(__SPEC_GENERATED_FIXTURES_DIR__ . "project_with_missing_code_xml/"));
    $this->shouldThrow('Catrobat\CoreBundle\Exceptions\InvalidCatrobatFileException')->during('__construct', array(__SPEC_GENERATED_FIXTURES_DIR__ . "project_with_invalid_code_xml/"));
    $this->beConstructedWith(__SPEC_GENERATED_FIXTURES_DIR__."base/");
  }
  
  function it_is_initializable()
  {
    $this->shouldHaveType('Catrobat\CoreBundle\Model\ExtractedCatrobatFile');
  }

  function it_gets_the_project_name_from_xml()
  {
    $this->getName()->shouldReturn("compass");
  }

  function it_gets_the_project_description_from_xml()
  {
    $this->getDescription()->shouldReturn("");
  }
  
  function it_gets_the_language_version_from_xml()
  {
    $this->getLanguageVersion()->shouldReturn("0.9");
  }
  
  function it_gets_the_application_version_from_xml()
  {
    $this->getApplicationVersion()->shouldReturn("0.8.5");
  }
  
  function it_returns_the_path_of_the_base_directory()
  {
    $this->getPath()->shouldReturn(__SPEC_GENERATED_FIXTURES_DIR__."base/");
  }
  
  function it_returns_the_xml_properties()
  {
    $this->getProjectXmlProperties()->shouldHaveType('SimpleXMLElement');
  }
  
  function it_returns_the_path_of_the_automatic_screenshot()
  {
    $this->getScreenshotPath()->shouldReturn(__SPEC_GENERATED_FIXTURES_DIR__."base/automatic_screenshot.png");
  }
  
  function it_returns_the_path_of_the_manual_screenshot()
  {
    $this->beConstructedWith(__SPEC_GENERATED_FIXTURES_DIR__."project_with_manual_screenshot/");
    $this->getScreenshotPath()->shouldReturn(__SPEC_GENERATED_FIXTURES_DIR__."project_with_manual_screenshot/manual_screenshot.png");
  }
  
  function it_returns_the_path_of_the_screenshot()
  {
    $this->beConstructedWith(__SPEC_GENERATED_FIXTURES_DIR__."project_with_screenshot/");
    $this->getScreenshotPath()->shouldReturn(__SPEC_GENERATED_FIXTURES_DIR__."project_with_screenshot/screenshot.png");
  }
}
